From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 4 Jan 2018 15:48:37 +0000
Subject: [Intel-wired-lan] [PATCH 7/9] ixgbevf: clear rx_buffer_info in
 configure instead of clean
In-Reply-To: <20171211183720.21524.93082.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
 <20171211183720.21524.93082.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64B3EF3A@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Emil Tantilov
> Sent: Monday, December 11, 2017 10:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 7/9] ixgbevf: clear rx_buffer_info in configure
> instead of clean
> 
> Based on commit d2bead576e67
> ("igb: Clear Rx buffer_info in configure instead of clean")
> 
> This change makes it so that instead of going through the entire ring on Rx
> cleanup we only go through the region that was designated to be cleaned up
> and stop when we reach the region where new allocations should start.
> 
> In addition we can avoid having to perform a memset on the Rx buffer_info
> structures until we are about to start using the ring again.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


