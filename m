From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Fri, 23 Sep 2016 16:01:11 +0000
Subject: [Intel-wired-lan] ixgbe FdirMode for Perfect filter mode
In-Reply-To: <22B3FA801D86A143A7D448636913BBD2C2BB52@ESESSMB107.ericsson.se>
References: <22B3FA801D86A143A7D448636913BBD2C2BB52@ESESSMB107.ericsson.se>
Message-ID: <87618083B2453E4A8714035B62D67992506E7B4C@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>Behalf Of Kurien Mathew
>Sent: Friday, September 23, 2016 7:57 AM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] ixgbe FdirMode for Perfect filter mode
>
>Hello,
>
>On module ixgbe, I am looking to set option FdirMode
><https://www.kernel.org/doc/Documentation/networking/ixgbe.txt>  to 2 so as
>to enable the "Perfect filter" mode. This parameter is not reported by
>"modinfo ixgbe" and using it in /etc/modprobe.d/ixgbe.conf causes "modprobe
>ixgbe" to fail with the message "ixgbe: Unknown parameter `FdirMode'" in
>dmesg.

In the paragraph right above FdirMode (which does not exist anymore btw)
there is an example of enabling perfect filters with ethtool.

Thanks,
Emil

