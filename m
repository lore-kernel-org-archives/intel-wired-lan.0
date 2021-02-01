From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 1 Feb 2021 08:47:47 -0800
Subject: [Intel-wired-lan] [PATCH net] igb: Enable RSS for Intel I211
 Ethernet Controller
In-Reply-To: <379d4ef3-02e5-f08a-1b04-21848e11a365@bluematt.me>
References: <20201221222502.1706-1-nick.lowe@gmail.com>
 <379d4ef3-02e5-f08a-1b04-21848e11a365@bluematt.me>
Message-ID: <20210201084747.2cb64c3f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 31 Jan 2021 18:17:11 -0500 Matt Corallo wrote:
> Given this fixes a major (albeit ancient) performance regression, is
> it not a candidate for backport? It landed on Tony's dev-queue branch
> with a Fixes tag but no stable CC.

Tony's tree needs to get fed into net, then net into Linus's tree and
then we can do the backport :(
