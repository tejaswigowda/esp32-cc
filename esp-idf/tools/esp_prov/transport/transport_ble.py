# Copyright 2018 Espressif Systems (Shanghai) PTE LTD
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

from __future__ import print_function

from .transport import Transport

from . import ble_cli


class Transport_BLE(Transport):
    def __init__(self, devname, service_uuid, nu_lookup):
        # Expect service UUID like '0000ffff-0000-1000-8000-00805f9b34fb'
        for name in nu_lookup.keys():
            # Calculate characteristic UUID for each endpoint
            nu_lookup[name] = service_uuid[:4] + '{:02x}'.format(
                int(nu_lookup[name], 16) & int(service_uuid[4:8], 16)) + service_uuid[8:]
        self.name_uuid_lookup = nu_lookup

        # Get BLE client module
        self.cli = ble_cli.get_client()

        # Use client to connect to BLE device and bind to service
        if not self.cli.connect(devname=devname, iface='hci0', srv_uuid=service_uuid):
            raise RuntimeError("Failed to initialize transport")

        # Check if expected characteristics are provided by the service
        for name in self.name_uuid_lookup.keys():
            if not self.cli.has_characteristic(self.name_uuid_lookup[name]):
                raise RuntimeError("'" + name + "' endpoint not found")

    def __del__(self):
        # Make sure device is disconnected before application gets closed
        try:
            self.disconnect()
        except Exception:
            pass

    def disconnect(self):
        self.cli.disconnect()

    def send_data(self, ep_name, data):
        # Write (and read) data to characteristic corresponding to the endpoint
        if ep_name not in self.name_uuid_lookup.keys():
            raise RuntimeError("Invalid endpoint : " + ep_name)
        return self.cli.send_data(self.name_uuid_lookup[ep_name], data)
