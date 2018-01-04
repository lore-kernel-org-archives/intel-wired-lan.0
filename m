From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 4 Jan 2018 15:43:44 +0000
Subject: [Intel-wired-lan] [PATCH 2/9] ixgbevf: only DMA sync frame
 length
In-Reply-To: <20171211183654.21524.84943.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
 <20171211183654.21524.84943.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64B3EEC8@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 2/9] ixgbevf: only DMA sync frame length
> 
> Based on commit 64f2525ca4e7 ("igb: Only DMA sync frame length")
> 
> On some architectures synching a buffer for DMA may be expensive.
> Instead of the entire 2K receive buffer only synchronize the length of
> the frame, which will typically be the MTU or smaller.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

