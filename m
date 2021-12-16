From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 16 Dec 2021 07:47:39 -0800
Subject: [Intel-wired-lan] [net-queue PATCH 0/5] i40e: stat counter
 updates and additions
In-Reply-To: <1639521730-57226-1-git-send-email-jdamato@fastly.com>
References: <1639521730-57226-1-git-send-email-jdamato@fastly.com>
Message-ID: <20211216074739.7f71a01b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 14 Dec 2021 14:42:05 -0800 Joe Damato wrote:
> This patch set makes several updates to the i40e driver stats collection
> and reporting code to help users of i40e get a better sense of how the
> driver is performing and interacting with the rest of the kernel.
> 
> These patches include some new stats (like waived and busy) which were
> inspired by other drivers that track stats using the same nomenclature.
> 
> The new stats and an existing stat, rx_reuse, are now accessible with
> ethtool to make harvesting this data more convenient for users.

Looks good overall, thanks.
