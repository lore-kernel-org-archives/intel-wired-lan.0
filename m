From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 21 Jun 2019 01:45:21 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] net: intel: igb: minor ethool
 regdump amendment
In-Reply-To: <20190618115513.99661-1-dedekind1@gmail.com>
References: <20190618115513.99661-1-dedekind1@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970B125D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2019-06-18 at 14:55 +0300, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> This patch has no functional impact and it is just a preparation
> for the following patch. It removes an early return from the
> 'igb_get_regs()' function by moving the 82576-only registers
> dump into an "if" block. With this preparation, we can dump more
> non-82576 registers at the end of this function.
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 70 ++++++++++----------
>  1 file changed, 35 insertions(+), 35 deletions(-)
> 
Aside from teh missing "t" for ethtool in the subject that Andrew Lunn pointed out...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
