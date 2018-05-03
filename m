From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 3 May 2018 20:29:38 +0000
Subject: [Intel-wired-lan] [PATCH v6 0/5] PCI: Improve PCIe link status
 reporting
In-Reply-To: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <02874ECE860811409154E81DA85FBB5882DBA48B@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> This does change the dmesg reporting of link speeds, and in the ixgbe case,
> it changes the reporting from KERN_WARN level to KERN_INFO.  If that's an
> issue, let's talk about it.  I'm hoping the reduce code size, improved
> functionality, and consistency across drivers is enough to make this
> worthwhile.
> 

I personally have no issue with this change, but I don't work on the ixgbe driver much anymore.

Thanks,
Jake

