From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 8 Jan 2016 21:06:31 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: use bit operations for
 setting	and checking resets
In-Reply-To: <20151218013255.24602.41039.stgit@localhost6.localdomain6>
References: <20151218013255.24602.41039.stgit@localhost6.localdomain6>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180D1462B@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, December 17, 2015 5:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: use bit operations for setting and
> checking resets
> 
> Move the reset flags to adapter->state in order to make use of bit operations.
> 
> This is an alternative patch to the one previously submitted by John Greene.
> 
> Suggested-by: Alexander Duyck <aduyck@mirantis.com>
> Reported-by: Scott Otto <otts62@yahoo.com>
> Reported-by: John Greene <jogreene@redhat.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>

