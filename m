From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 16 Dec 2021 07:45:45 -0800
Subject: [Intel-wired-lan] [net-queue PATCH 1/5] i40e: Remove rx page
 reuse double count.
In-Reply-To: <1639521730-57226-2-git-send-email-jdamato@fastly.com>
References: <1639521730-57226-1-git-send-email-jdamato@fastly.com>
 <1639521730-57226-2-git-send-email-jdamato@fastly.com>
Message-ID: <20211216074545.036ab8e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 14 Dec 2021 14:42:06 -0800 Joe Damato wrote:
> Page reuse was being tracked from two locations:
>   - i40e_reuse_rx_page (via 40e_clean_rx_irq), and
>   - i40e_alloc_mapped_page
> 
> Remove the double count and only count reuse from i40e_alloc_mapped_page
> when the page is about to be reused.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Possibly a fix, this one?
