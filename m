From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Tue, 22 Dec 2015 23:19:16 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: report correct media type for
 KR, KX and KX4 interfaces
In-Reply-To: <20151111232259.4471.80984.stgit@larettin-mobl2.amr.corp.intel.com>
References: <20151111232259.4471.80984.stgit@larettin-mobl2.amr.corp.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CFAEA9@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Veola
> Sent: Wednesday, November 11, 2015 3:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: report correct media type for KR, KX
> and KX4 interfaces
> 
> ethtool reports backplane type interfaces as 1000/10000baseT link modes.
> This has been corrected to report the media as KR, KX or KX4 based on the
> backplane interface present.
> 
> Signed-off-by: Veola <veola.nazareth@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>

