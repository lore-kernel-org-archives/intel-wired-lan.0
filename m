From: Paul Stewart <pstew@google.com>
Date: Wed, 18 Dec 2019 14:54:26 -0800
Subject: [Intel-wired-lan] Setting PHY modes in ixgbe
Message-ID: <CAMcMvsiZ72fGryE=Hrh0jg0Fdm35dcuwi--KW2-gRW6zX9-0NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We're creating a device that uses SGMII for communication.  The
C3000-based SOM we're using defaults to KX.   Intel's documentation
and drivers offers almost all we need.  The C3000 document refers to
the mode being configurable via the "the 2-bit Link Mode field (bits
[5:4]) of the Initialization Control 3 word, located at 16-bit word
offset 0x24 of the particular LAN-port base
address of the shared SPI Flash."  It then has a table with 11 entries
in it that show the various modes (VF, KR, KX, SFI, SGMII, etc) that
it can enter.  I have a couple questions though:

 - How does one map this "particular LAN-port base address" to an
actual byte offset in the EEPROM?
 - How do those two bits map to the 11 different options shown?
