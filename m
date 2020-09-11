From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 11 Sep 2020 08:33:54 -0700
Subject: [Intel-wired-lan] [PATCH net-next] i40e: allow VMDQs to be used
 with AF_XDP zero-copy
In-Reply-To: <1599826106-19020-1-git-send-email-magnus.karlsson@gmail.com>
References: <1599826106-19020-1-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <20200911083354.7e501505@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 11 Sep 2020 14:08:26 +0200 Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Allow VMDQs to be used with AF_XDP sockets in zero-copy mode. For some
> reason, we only allowed main VSIs to be used with zero-copy, but
> there is now reason to not allow VMDQs also.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

The VMQ interfaces that you create through a debugfs command interfaces?

IDK if we should add features to those, or pretend they never existed
in the first place..
