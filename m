From: Doron Shikmoni <doron.shikmoni@gmail.com>
Date: Sun, 27 Sep 2015 13:31:03 +0300
Subject: [Intel-wired-lan] Proposed patch for igb: incorrect output for
	"ethtool -m"
Message-ID: <CAEvZX5f8pcS-DobQvaznX72_kvNz3QvPOj-8DEOJ57o_7tJDOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Gentlefolks,

The next e-mail contains a proposed patch to igb. It addresses a problem
(probably long-standing) in reading the "module EEPROM", which manifests
itself in garbled output to "ethtool -m ethX" for igb-driven NICs (igxbe,
for example, gets it right). Sample garbled output is pasted below. As you
can see, EEPROM data bytes are duplicated.
The issue is within igb_read_module_eeprom(), which, while reading the ee
data via i2c a word at a time, passes the read offset as #words when it is
expected to be a byte offset.

Proposed patch in the next mail. Tested to work well in my environments.

Thank you,
Doron


Sample incorrect output:
==
ethtool -m eth4
               Identifier          : 0x03 (SFP)
               Extended identifier : 0x04 (GBIC/SFP defined by 2-wire
interface ID)
               Connector           : 0x04 (BNC/TNC)
               Transceiver codes   : 0x07 0x07 0x000x00 0x00 0x00 0x00 0x00
                                   :  => Infiniband: 1X LX
                                   :  => Infiniband: 1X Copper Active
                                   :  => Infiniband: 1X Copper Passive
                                   :  => SONET: OC-48, long reach
                                   :  => SONET: OC-48, intermediate reach
                                   :  => SONET: OC-48, short reach
               Encoding            : 0x01 (8B/10B)
               BR, Nominal         : 100MBd
               Rate identifier     : 0x20 (reserved or unknown)
               Length (SMF,km)     : 32km
               Length (SMF)        : 6400m
               Length (50um)       : 640m
               Length (62.5um)     : 120m
               Length (Copper)     : 12m
               Length (OM3)        : 50m
               Laser wavelength    : 21072nm
               Vendor name         : ________________
               Vendor OUI          : 00:00:46
               Vendor PN           : FIINNIISSAARR  C
               Vendor rev          : COOR

(full ee buffer can be examined via "ethtool -m ethX raw on")
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150927/adc53c97/attachment.html>
