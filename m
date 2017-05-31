From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 31 May 2017 18:50:42 +0300
Subject: [Intel-wired-lan] [PULL] topic/e1000e-fix
In-Reply-To: <20170531.110833.1362264472730468352.davem@davemloft.net>
References: <20170531.110833.1362264472730468352.davem@davemloft.net>
Message-ID: <20170531155043.3596-1-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 31 May 2017, David Miller <davem@davemloft.net> wrote:
> And we can't understand why respinning with the requested change is
> less work than making several postings such as this one.

When our CI hits tons of non-drm issues every merge window, I imagine
our developers can start to get a little frustrated trying to get them
fixed. Especially so when valid fixes like this get blocked by silly
bikesheds from developers who don't even seem to have very many
contributions upstream, and the maintainers don't respond. We have
enough on our plates trying to get our own stuff fixed.

While I understand why our developers aren't willing to jump through all
the hoops, updated patch follows. Please let's move on.

BR,
Jani.


Chris Wilson (1):
  e1000e: Undo e1000e_pm_freeze if __e1000_shutdown fails

 drivers/net/ethernet/intel/e1000e/netdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.11.0

