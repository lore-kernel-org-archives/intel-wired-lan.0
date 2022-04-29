From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Fri, 29 Apr 2022 15:50:33 +0200
Subject: [Intel-wired-lan] [RFC v2 21/39] net: add HAS_IOPORT dependencies
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
Message-ID: <20220429135108.2781579-36-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them. It also turns out that with HAS_IOPORT handled
explicitly HAMRADIO does not need the !S390 dependency and successfully
builds the bpqether driver.

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/net/Kconfig                | 2 +-
 drivers/net/arcnet/Kconfig         | 2 +-
 drivers/net/can/cc770/Kconfig      | 1 +
 drivers/net/can/sja1000/Kconfig    | 1 +
 drivers/net/ethernet/8390/Kconfig  | 2 +-
 drivers/net/ethernet/amd/Kconfig   | 2 +-
 drivers/net/ethernet/intel/Kconfig | 2 +-
 drivers/net/ethernet/sis/Kconfig   | 4 ++--
 drivers/net/ethernet/ti/Kconfig    | 2 +-
 drivers/net/ethernet/via/Kconfig   | 1 +
 drivers/net/fddi/Kconfig           | 2 +-
 drivers/net/hamradio/Kconfig       | 6 +++---
 drivers/net/wan/Kconfig            | 2 +-
 net/ax25/Kconfig                   | 2 +-
 14 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index b2a4f998c180..5bc1324150c2 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -475,7 +475,7 @@ source "drivers/net/ipa/Kconfig"
 
 config NET_SB1000
 	tristate "General Instruments Surfboard 1000"
-	depends on PNP
+	depends on ISA && PNP
 	help
 	  This is a driver for the General Instrument (also known as
 	  NextLevel) SURFboard 1000 internal
diff --git a/drivers/net/arcnet/Kconfig b/drivers/net/arcnet/Kconfig
index a51b9dab6d3a..d1d07a1d4fbc 100644
--- a/drivers/net/arcnet/Kconfig
+++ b/drivers/net/arcnet/Kconfig
@@ -4,7 +4,7 @@
 #
 
 menuconfig ARCNET
-	depends on NETDEVICES && (ISA || PCI || PCMCIA)
+	depends on NETDEVICES && (ISA || PCI || PCMCIA) && HAS_IOPORT
 	tristate "ARCnet support"
 	help
 	  If you have a network card of this type, say Y and check out the
diff --git a/drivers/net/can/cc770/Kconfig b/drivers/net/can/cc770/Kconfig
index 9ef1359319f0..467ef19de1c1 100644
--- a/drivers/net/can/cc770/Kconfig
+++ b/drivers/net/can/cc770/Kconfig
@@ -7,6 +7,7 @@ if CAN_CC770
 
 config CAN_CC770_ISA
 	tristate "ISA Bus based legacy CC770 driver"
+	depends on ISA
 	help
 	  This driver adds legacy support for CC770 and AN82527 chips
 	  connected to the ISA bus using I/O port, memory mapped or
diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index 110071b26921..be1943a27ed0 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -87,6 +87,7 @@ config CAN_PLX_PCI
 
 config CAN_SJA1000_ISA
 	tristate "ISA Bus based legacy SJA1000 driver"
+	depends on ISA
 	help
 	  This driver adds legacy support for SJA1000 chips connected to
 	  the ISA bus using I/O port, memory mapped or indirect access.
diff --git a/drivers/net/ethernet/8390/Kconfig b/drivers/net/ethernet/8390/Kconfig
index a4130e643342..3e727407d8f5 100644
--- a/drivers/net/ethernet/8390/Kconfig
+++ b/drivers/net/ethernet/8390/Kconfig
@@ -117,7 +117,7 @@ config NE2000
 
 config NE2K_PCI
 	tristate "PCI NE2000 and clones support (see help)"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select CRC32
 	help
 	  This driver is for NE2000 compatible PCI cards. It will not work
diff --git a/drivers/net/ethernet/amd/Kconfig b/drivers/net/ethernet/amd/Kconfig
index 899c8a2a34b6..019810eeb68d 100644
--- a/drivers/net/ethernet/amd/Kconfig
+++ b/drivers/net/ethernet/amd/Kconfig
@@ -56,7 +56,7 @@ config LANCE
 
 config PCNET32
 	tristate "AMD PCnet32 PCI support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select CRC32
 	select MII
 	help
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 3facb55b7161..6bdce8eb689d 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -41,7 +41,7 @@ config E100
 
 config E1000
 	tristate "Intel(R) PRO/1000 Gigabit Ethernet support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  This driver supports Intel(R) PRO/1000 gigabit ethernet family of
 	  adapters.  For more information on how to identify your adapter, go
diff --git a/drivers/net/ethernet/sis/Kconfig b/drivers/net/ethernet/sis/Kconfig
index 775d76d9890e..7e498bdbca73 100644
--- a/drivers/net/ethernet/sis/Kconfig
+++ b/drivers/net/ethernet/sis/Kconfig
@@ -19,7 +19,7 @@ if NET_VENDOR_SIS
 
 config SIS900
 	tristate "SiS 900/7016 PCI Fast Ethernet Adapter support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select CRC32
 	select MII
 	help
@@ -35,7 +35,7 @@ config SIS900
 
 config SIS190
 	tristate "SiS190/SiS191 gigabit ethernet support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select CRC32
 	select MII
 	help
diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index affcf92cd3aa..b5cc714adda4 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -159,7 +159,7 @@ config TI_KEYSTONE_NETCP_ETHSS
 
 config TLAN
 	tristate "TI ThunderLAN support"
-	depends on (PCI || EISA)
+	depends on (PCI || EISA) && HAS_IOPORT
 	help
 	  If you have a PCI Ethernet network card based on the ThunderLAN chip
 	  which is supported by this driver, say Y here.
diff --git a/drivers/net/ethernet/via/Kconfig b/drivers/net/ethernet/via/Kconfig
index da287ef65be7..00773f5e4d7e 100644
--- a/drivers/net/ethernet/via/Kconfig
+++ b/drivers/net/ethernet/via/Kconfig
@@ -20,6 +20,7 @@ config VIA_RHINE
 	tristate "VIA Rhine support"
 	depends on PCI || (OF_IRQ && GENERIC_PCI_IOMAP)
 	depends on PCI || ARCH_VT8500 || COMPILE_TEST
+	depends on HAS_IOPORT
 	depends on HAS_DMA
 	select CRC32
 	select MII
diff --git a/drivers/net/fddi/Kconfig b/drivers/net/fddi/Kconfig
index 846bf41c2717..fa3f1e0fe143 100644
--- a/drivers/net/fddi/Kconfig
+++ b/drivers/net/fddi/Kconfig
@@ -29,7 +29,7 @@ config DEFZA
 
 config DEFXX
 	tristate "Digital DEFTA/DEFEA/DEFPA adapter support"
-	depends on FDDI && (PCI || EISA || TC)
+	depends on FDDI && (PCI || EISA || TC) && HAS_IOPORT
 	help
 	  This is support for the DIGITAL series of TURBOchannel (DEFTA),
 	  EISA (DEFEA) and PCI (DEFPA) controllers which can connect you
diff --git a/drivers/net/hamradio/Kconfig b/drivers/net/hamradio/Kconfig
index 441da03c23ee..61c0bc156870 100644
--- a/drivers/net/hamradio/Kconfig
+++ b/drivers/net/hamradio/Kconfig
@@ -117,7 +117,7 @@ config SCC_TRXECHO
 
 config BAYCOM_SER_FDX
 	tristate "BAYCOM ser12 fullduplex driver for AX.25"
-	depends on AX25 && !S390
+	depends on AX25 && HAS_IOPORT
 	select CRC_CCITT
 	help
 	  This is one of two drivers for Baycom style simple amateur radio
@@ -137,7 +137,7 @@ config BAYCOM_SER_FDX
 
 config BAYCOM_SER_HDX
 	tristate "BAYCOM ser12 halfduplex driver for AX.25"
-	depends on AX25 && !S390
+	depends on AX25 && HAS_IOPORT
 	select CRC_CCITT
 	help
 	  This is one of two drivers for Baycom style simple amateur radio
@@ -185,7 +185,7 @@ config BAYCOM_EPP
 
 config YAM
 	tristate "YAM driver for AX.25"
-	depends on AX25 && !S390
+	depends on AX25 && HAS_IOPORT
 	help
 	  The YAM is a modem for packet radio which connects to the serial
 	  port and includes some of the functions of a Terminal Node
diff --git a/drivers/net/wan/Kconfig b/drivers/net/wan/Kconfig
index 140780ac1745..e62a51098836 100644
--- a/drivers/net/wan/Kconfig
+++ b/drivers/net/wan/Kconfig
@@ -250,7 +250,7 @@ config C101
 
 config FARSYNC
 	tristate "FarSync T-Series support"
-	depends on HDLC && PCI
+	depends on HDLC && PCI && HAS_IOPORT
 	help
 	  Support for the FarSync T-Series X.21 (and V.35/V.24) cards by
 	  FarSite Communications Ltd.
diff --git a/net/ax25/Kconfig b/net/ax25/Kconfig
index d3a9843a043d..f769e8f4bd02 100644
--- a/net/ax25/Kconfig
+++ b/net/ax25/Kconfig
@@ -4,7 +4,7 @@
 #
 
 menuconfig HAMRADIO
-	depends on NET && !S390
+	depends on NET
 	bool "Amateur Radio support"
 	help
 	  If you want to connect your Linux box to an amateur radio, answer Y
-- 
2.32.0

