From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Fri, 14 Aug 2015 03:33:35 +0000
Subject: [Intel-wired-lan] ixgbe on Xeon D-1540 does not come up at
	1	gigabit or 100Mbps speeds
In-Reply-To: <20150813185607.GL24295@kvack.org>
References: <20150813185607.GL24295@kvack.org>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD6535C9B5A@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

You may want to post this to e1000-devel at lists.sourceforge.net, or file a bug on e1000.sourceforge.net. I think this list is mainly for patches.

In the mean time I'll see if there's anything odd going on with that part.

Thanks.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Benjamin LaHaise
Sent: Thursday, August 13, 2015 11:56 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] ixgbe on Xeon D-1540 does not come up at 1 gigabit or 100Mbps speeds

Hello,

I have just tried to set up a new Xeon D-1540 system (a Supermicro X10SDV-8C-TLN4F), and it appears that the ixgbe driver in Linus' tree as of commit 58ccab91342c1cc1fe08da9b198ac5d763706c2e is unable to negotiate link up at either gigabit or 100Mbps speeds.  If I plug the 10Gbase-T into each other back to back, the ports are able to come up and transfer data.  Please let me know if any further information is required to reproduce this bug.

		-ben
--
"Thought is the essence of where you are now."
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
