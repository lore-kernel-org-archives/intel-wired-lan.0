From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 23 Sep 2021 15:55:47 -0700
Subject: [Intel-wired-lan] [PATCH net-next 0/6] Batch of devlink related
 fixes
In-Reply-To: <cover.1632420430.git.leonro@nvidia.com>
References: <cover.1632420430.git.leonro@nvidia.com>
Message-ID: <20210923155547.248ab1aa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 23 Sep 2021 21:12:47 +0300 Leon Romanovsky wrote:
> I'm asking to apply this batch of devlink fixes to net-next and not to
> net, because most if not all fixes are for old code or/and can be considered
> as cleanup.
> 
> It will cancel the need to deal with merge conflicts for my next devlink series :).

Not sure how Dave will feel about adding fixes to net-next,
we do merge the trees weekly after all.

Otherwise the patches look fine.
