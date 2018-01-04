From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 4 Jan 2018 15:41:41 +0000
Subject: [Intel-wired-lan] [PATCH 1/9] ixgbevf: add function for
 checking if we can reuse page
In-Reply-To: <20171211183649.21524.3888.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
 <20171211183649.21524.3888.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64B3EEAE@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 1/9] ixgbevf: add function for checking if we
> can reuse page
> 
> Introduce ixgbevf_can_reuse_page() similar to the change in ixgbe from
> commit af43da0dba0b
> ("ixgbe: Add function for checking to see if we can reuse page")
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   59 ++++++++++++---------
>  1 file changed, 33 insertions(+), 26 deletions(-)

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


