From: Kurien Mathew <kurien.mathew@ericsson.com>
Date: Fri, 23 Sep 2016 14:56:45 +0000
Subject: [Intel-wired-lan] ixgbe FdirMode for Perfect filter mode
Message-ID: <22B3FA801D86A143A7D448636913BBD2C2BB52@ESESSMB107.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

On module ixgbe, I am looking to set option FdirMode<https://www.kernel.org/doc/Documentation/networking/ixgbe.txt> to 2 so as to enable the "Perfect filter" mode. This parameter is not reported by "modinfo ixgbe" and using it in /etc/modprobe.d/ixgbe.conf causes "modprobe ixgbe" to fail with the message "ixgbe: Unknown parameter `FdirMode'" in dmesg.

How can one activate the "Perfect filter" mode mentioned in the module readme<https://sourceforge.net/projects/e1000/files/ixgbe%20stable/4.4.6/ixgbe-4.4.6.tar.gz/download>?

Kurien


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160923/30373d0b/attachment.html>
