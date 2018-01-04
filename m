From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 4 Jan 2018 15:47:41 +0000
Subject: [Intel-wired-lan] [PATCH 6/9] ixgbevf: add counters for Rx page
 allocations
In-Reply-To: <20171211183715.21524.56950.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
 <20171211183715.21524.56950.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64B3EF20@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 6/9] ixgbevf: add counters for Rx page
> allocations
> 
> We already had placehloders for failed page and buffer allocations.
> Added alloc_rx_page and made sure the stats are properly updated and
> exposed in ethtool.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

