From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 7 Dec 2015 18:49:45 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: do not report 2.5 Gbps as
 supported
In-Reply-To: <20151107003433.20895.67529.stgit@localhost6.localdomain6>
References: <20151107003433.20895.67529.stgit@localhost6.localdomain6>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CF3F4F@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, November 06, 2015 4:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: do not report 2.5 Gbps as supported
> 
> Some X550 devices can connect at 2.5Gbps during fail-over, but only with
> certain link partners. Also setting the advertised speed will not work so we do
> not report it as supported to avoid confusion.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>


Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
