From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Tue, 26 Jun 2018 06:49:09 -0300
Subject: [Intel-wired-lan] [PATCH 7/9] networking: e100.rst: Get rid of
 Sphinx warnings
In-Reply-To: <cover.1530005114.git.mchehab+samsung@kernel.org>
References: <cover.1530005114.git.mchehab+samsung@kernel.org>
Message-ID: <48ca5da5770c63ec56e9e9df76e3528c1bcb4414.1530005114.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

    Documentation/networking/e100.rst:57: WARNING: Literal block expected; none found.
    Documentation/networking/e100.rst:68: WARNING: Literal block expected; none found.
    Documentation/networking/e100.rst:75: WARNING: Literal block expected; none found.
    Documentation/networking/e100.rst:84: WARNING: Literal block expected; none found.
    Documentation/networking/e100.rst:93: WARNING: Inline emphasis start-string without end-string.

While here, fix some highlights.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/networking/e100.rst | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/e100.rst b/Documentation/networking/e100.rst
index 9708f5fa76de..f81111eba9c5 100644
--- a/Documentation/networking/e100.rst
+++ b/Documentation/networking/e100.rst
@@ -47,41 +47,45 @@ Driver Configuration Parameters
 The default value for each parameter is generally the recommended setting,
 unless otherwise noted.
 
-Rx Descriptors: Number of receive descriptors. A receive descriptor is a data
+Rx Descriptors:
+   Number of receive descriptors. A receive descriptor is a data
    structure that describes a receive buffer and its attributes to the network
    controller. The data in the descriptor is used by the controller to write
    data from the controller to host memory. In the 3.x.x driver the valid range
    for this parameter is 64-256. The default value is 256. This parameter can be
    changed using the command::
 
-   ethtool -G eth? rx n
+     ethtool -G eth? rx n
 
    Where n is the number of desired Rx descriptors.
 
-Tx Descriptors: Number of transmit descriptors. A transmit descriptor is a data
+Tx Descriptors:
+   Number of transmit descriptors. A transmit descriptor is a data
    structure that describes a transmit buffer and its attributes to the network
    controller. The data in the descriptor is used by the controller to read
    data from the host memory to the controller. In the 3.x.x driver the valid
    range for this parameter is 64-256. The default value is 128. This parameter
    can be changed using the command::
 
-   ethtool -G eth? tx n
+     ethtool -G eth? tx n
 
    Where n is the number of desired Tx descriptors.
 
-Speed/Duplex: The driver auto-negotiates the link speed and duplex settings by
+Speed/Duplex:
+   The driver auto-negotiates the link speed and duplex settings by
    default. The ethtool utility can be used as follows to force speed/duplex.::
 
-   ethtool -s eth?  autoneg off speed {10|100} duplex {full|half}
+     ethtool -s eth?  autoneg off speed {10|100} duplex {full|half}
 
    NOTE: setting the speed/duplex to incorrect values will cause the link to
    fail.
 
-Event Log Message Level:  The driver uses the message level flag to log events
+Event Log Message Level:
+   The driver uses the message level flag to log events
    to syslog. The message level can be set at driver load time. It can also be
    set using the command::
 
-   ethtool -s eth? msglvl n
+     ethtool -s eth? msglvl n
 
 
 Additional Configurations
@@ -92,7 +96,7 @@ Configuring the Driver on Different Distributions
 
 Configuring a network driver to load properly when the system is started
 is distribution dependent.  Typically, the configuration process involves
-adding an alias line to /etc/modprobe.d/*.conf as well as editing other
+adding an alias line to `/etc/modprobe.d/*.conf` as well as editing other
 system startup scripts and/or configuration files.  Many popular Linux
 distributions ship with tools to make these changes for you.  To learn
 the proper way to configure a network device for your system, refer to
@@ -160,7 +164,10 @@ This results in unbalanced receive traffic.
 If you have multiple interfaces in a server, either turn on ARP
 filtering by
 
-(1) entering:: echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
+(1) entering::
+
+	echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
+
     (this only works if your kernel's version is higher than 2.4.5), or
 
 (2) installing the interfaces in separate broadcast domains (either
-- 
2.17.1

