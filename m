From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Sep 2019 01:15:38 +0000
Subject: [Intel-wired-lan] [PATCH] e1000: fix memory leaks
In-Reply-To: <1565589561-5910-1-git-send-email-wenwen@cs.uga.edu>
References: <1565589561-5910-1-git-send-email-wenwen@cs.uga.edu>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971184F9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2019-08-12 at 00:59 -0500, Wenwen Wang wrote:
> In e1000_set_ringparam(), 'tx_old' and 'rx_old' are not deallocated if
> e1000_up() fails, leading to memory leaks. Refactor the code to fix this
> issue.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
