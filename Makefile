# Copyright (c) 2018 Spartaco Amadei <spamadei@gmail.com>

# This program is free software: you can redistribute it and/or modify #
# it under the terms of the GNU General Public License as published by #
# the Free Software Foundation, either version 3 of the License, or    #
# (at your option) any later version.                                  #
#                                                                      #
# This program is distributed in the hope that it will be useful,      # 
# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
# GNU General Public License for more details.                         #
#                                                                      #
# You should have received a copy of the GNU General Public License    #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.#

PROGNM = paura
LIB = libpaura
PREFIX ?= /usr
SHRDIR ?= $(PREFIX)/share
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib

.PHONY: install
install:
	@install -Dm755 paura     -t $(DESTDIR)$(BINDIR)
	@install -Dm755 libpaura/*   -t $(DESTDIR)$(LIBDIR)/$(LIB)
	@install -Dm644 man1/*  -t $(DESTDIR)$(SHRDIR)/man/man1
	@install -Dm644 COPYNG -t $(DESTDIR)$(SHRDIR)/licenses/$(PROGNM)

uninstall:
	@rm -r $(DESTDIR)$(BINDIR)/$(PROGNM)
	@rm -r $(DESTDIR)$(LIBDIR)/$(LIB)
	@rm -r $(DESTDIR)$(SHRDIR)/man/man1/$(PROGNM).1*
	@rm -r $(DESTDIR)$(SHRDIR)/licenses/$(PROGNM)
