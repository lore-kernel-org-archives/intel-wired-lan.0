From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 14 Sep 2020 05:04:25 +0200
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 11/11]
 drivers/net/ethernet: clean up mis-targeted comments
In-Reply-To: <115bce2a-daaa-a7c5-3c48-44ce345ea008@solarflare.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-12-jesse.brandeburg@intel.com>
 <227d2fe4-ddf8-89c9-b80b-142674c2cca0@solarflare.com>
 <20200911144207.00005619@intel.com>
 <e2e637ae-8cda-c9a4-91ce-93dbd475fc0c@solarflare.com>
 <20200911152642.62923ba2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <115bce2a-daaa-a7c5-3c48-44ce345ea008@solarflare.com>
Message-ID: <20200914030425.GG3463198@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Sep 12, 2020 at 12:11:20AM +0100, Edward Cree wrote:
> On 11/09/2020 23:26, Jakub Kicinski wrote:
> > "Toolchain" sounds a little grand in this context, the script that
> > parses kdoc does basic regexps to convert the standard kernel macros:
> > ...
> > IDK if we can expect it to understand random driver's macros..
> I wasn't suggesting it should _understand_ this macro, justrecognise
> ?when something _is_ a macro it doesn't understand, and refrain from
> ?warning about it in that case.

Is it possible to get the C preprocessor to expand the macros without
stripping the comments? Run the kerneldoc validator on that?

	  Andrew
