#!/usr/bin/python
# Copyright (C) Alex Kretzschmar
# https://github.com/ironicbadger/infra
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
class FilterModule(object):
    def filters(self):
        return {"duplicates": self.duplicates}

    def duplicates(self, items):
        sums = {}
        result = []

        for item in items:
            if item not in sums:
                sums[item] = 1
            else:
                if sums[item] == 1:
                    result.append(item)
                sums[item] += 1
        return result
