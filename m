From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 4 Jan 2018 15:46:58 +0000
Subject: [Intel-wired-lan] [PATCH 5/9] ixgbevf: update code to better
 handle incrementing page count
In-Reply-To: <20171211183709.21524.19432.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
 <20171211183709.21524.19432.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64B3EF07@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 5/9] ixgbevf: update code to better handle
> incrementing page count
> 
> Based on commit bd4171a5d4c2
> ("igb: update code to better handle incrementing page count")
> 
> Update the driver code so that we do bulk updates of the page reference
> count instead of just incrementing it by one reference at a time.  The
> advantage to doing this is that we cut down on atomic operations and
> this in turn should give us a slight improvement in cycles per packet.
> In addition if we eventually move this over to using build_skb the gains
> will be more noticeable.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


