From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Tue, 22 Dec 2015 23:04:49 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix RSS limit for X550
In-Reply-To: <20151120210216.15810.9572.stgit@localhost6.localdomain6>
References: <20151120210216.15810.9572.stgit@localhost6.localdomain6>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CFAE42@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, November 20, 2015 1:02 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix RSS limit for X550
> 
> X550 allows for up to 64 RSS queues, but the driver can have max of 63 (-1 MSIX
> vector for link).
> 
> On systems with >= 64 CPUs the driver will set the redirection table for all 64
> queues which will result in packets being dropped.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
