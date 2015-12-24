From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Thu, 24 Dec 2015 20:45:38 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: minor cleanups
	for	ixgbevf_set_itr()
In-Reply-To: <20151105000221.27372.83040.stgit@localhost6.localdomain6>
References: <20151105000221.27372.83040.stgit@localhost6.localdomain6>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CFBFB4@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, November 04, 2015 4:02 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: minor cleanups for ixgbevf_set_itr()
> 
> adapter->rx_itr_setting is not a mask so check it with == instead of &
> do not default to 12K interrupts in ixgbevf_set_itr()
> 
> There should be no functional effect from these changes.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
