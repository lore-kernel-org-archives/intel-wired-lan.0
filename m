From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 23 May 2017 17:31:33 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: fix incorrect status check
In-Reply-To: <20170518234506.32551.44123.stgit@localhost6.localdomain6>
References: <20170518234506.32551.44123.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E5966D5FD@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, May 18, 2017 4:45 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] ixgbe: fix incorrect status check
> 
> Check for ret_val instead of !ret_val to allow the rest of
> the code to execute and configure the speed properly.
> 
> v2 - fixed few more cases in ixgbe_setup_mac_link_sfp_n()
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

