From: Desouza, Ederson <ederson.desouza@intel.com>
Date: Thu, 18 Feb 2021 00:27:55 +0000
Subject: [Intel-wired-lan] [PATCH next-queue v1 2/2] igc: enable
 auxiliary PHC functions for the i225
In-Reply-To: <4a11d17d2b0b2e297de1e42fb76db076e9940712.camel@intel.com>
References: <20210212014212.41570-1-ederson.desouza@intel.com>
 <20210212014212.41570-3-ederson.desouza@intel.com>
 <bd0bfa55-de44-82e9-337a-e6254d3a8405@molgen.mpg.de>
 <4a11d17d2b0b2e297de1e42fb76db076e9940712.camel@intel.com>
Message-ID: <b42bc3f694b5d30f4bee163b65552a5d65d20706.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-02-17 at 23:53 +0000, Nguyen, Anthony L wrote:
> On Mon, 2021-02-15 at 11:05 +0100, Paul Menzel wrote:
> > Dear Ederson,
> > 
> > 
> > Am 12.02.21 um 02:42 schrieb Ederson de Souza:
> > > The i225 device offers a number of special PTP Hardware Clock
> > > features on
> > > the Software Defined Pins (SDPs). This patch adds support for two
> > > of the
> > > possible functions, namely time stamping external events, and
> > > periodic
> > > output signals.
> > > 
> > > The assignment of PHC functions to the four SDP can be freely
> > > chosen by
> > > the user.
> > > 
> > > While i225 allows up to four timers to be used to source the time
> > > used
> > > on the external events or output signals, this patch uses only one
> > > of
> > > those timers.
> > 
> > Why is that? Because it?s simpler to implement? Please add the reason
> > to 
> > the commit message.
> 
> I've applied this patch so testing can be done, but I agree with Paul.
> Some detail on why only one timer is being used would be nice.
> 
> Also, there are quite a few check/warnings from checkpatch that look
> like they can easily be remedied.

Sure, I'll address the review comments and checks and send a v2 soon.
Thanks for the reviews!

> 
> Thanks,
> Tony

