From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 1 Feb 2021 18:32:50 +0000
Subject: [Intel-wired-lan] [PATCH net] igb: Enable RSS for Intel I211
 Ethernet Controller
In-Reply-To: <20210201084747.2cb64c3f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201221222502.1706-1-nick.lowe@gmail.com>
 <379d4ef3-02e5-f08a-1b04-21848e11a365@bluematt.me>
 <20210201084747.2cb64c3f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <a7a89e90bf6c3f383fa236b1128db8d012223da0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-02-01 at 08:47 -0800, Jakub Kicinski wrote:
> On Sun, 31 Jan 2021 18:17:11 -0500 Matt Corallo wrote:
> > Given this fixes a major (albeit ancient) performance regression,
> > is
> > it not a candidate for backport? It landed on Tony's dev-queue
> > branch
> > with a Fixes tag but no stable CC.
> 
> Tony's tree needs to get fed into net, then net into Linus's tree and
> then we can do the backport :(

The behavior looks to have always been since support was introduced
with f96a8a0b7854 ("igb: Add Support for new i210/i211 devices."). I
was unable to determine the original reason for excluding it so I was
planning on sending through net-next as added functionality, however, I
will go ahead and send this through net and add it to the current
series that I need to make changes to.

Thanks,
Tony
