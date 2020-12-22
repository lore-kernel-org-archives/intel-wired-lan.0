From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 22 Dec 2020 09:43:52 -0800
Subject: [Intel-wired-lan] [PATCH 00/10] igc: Add support for AF_XDP
 zero-copy
In-Reply-To: <20201222142045.GI2943@ranger.igk.intel.com>
References: <20201217202415.77891-1-andre.guedes@intel.com>
 <20201222142045.GI2943@ranger.igk.intel.com>
Message-ID: <160865903286.65485.9554304438716971248@ticela-az-003.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Maciej Fijalkowski (2020-12-22 06:20:45)
> On Thu, Dec 17, 2020 at 12:24:05PM -0800, Andre Guedes wrote:
> > Hi,
> > 
> > This series adds AF_XDP zero-copy feature to igc driver.
> > 
> > The initial patches do some code refactoring, preparing the code base to
> > land the AF_XDP zero-copy feature, avoiding code duplications. The last
> > patches of the series are the ones implementing the feature.
> > 
> > The last patch which indeed implements AF_XDP zero-copy support was
> > originally way too lengthy so, for the sake of code review, I broke it
> > up into two patches: one adding support for the RX functionality and the
> > other one adding TX support. Feel free to squash those two patches when
> > pushing the series to net-next if you find appropriate.
> 
> Generally this looks good! I had only minor comments.

Thanks for your review, Maciej. I'm working on the v2 and should submit it
soon.

> I'm interested how are you going to utilize the AF_XDP ZC, probably
> something related to TSN ;)

Yes, that's right. In TSN use cases, tx and rx latency within the system is
relevant. AF_XDP ZC infra provides us a lower latency alternative to AF_PACKET.
