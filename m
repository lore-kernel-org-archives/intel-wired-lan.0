From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 20 Oct 2020 10:34:41 -0700
Subject: [Intel-wired-lan] [PATCH] net: remove unneeded break
In-Reply-To: <20201019172607.31622-1-trix@redhat.com>
References: <20201019172607.31622-1-trix@redhat.com>
Message-ID: <20201020103441.06dc6247@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 19 Oct 2020 10:26:07 -0700 trix at redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return or goto
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied, thanks!
