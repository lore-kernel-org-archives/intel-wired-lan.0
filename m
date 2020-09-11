From: Edward Cree <ecree@solarflare.com>
Date: Fri, 11 Sep 2020 22:55:54 +0100
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 11/11]
 drivers/net/ethernet: clean up mis-targeted comments
In-Reply-To: <20200911144207.00005619@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-12-jesse.brandeburg@intel.com>
 <227d2fe4-ddf8-89c9-b80b-142674c2cca0@solarflare.com>
 <20200911144207.00005619@intel.com>
Message-ID: <e2e637ae-8cda-c9a4-91ce-93dbd475fc0c@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/09/2020 22:42, Jesse Brandeburg wrote:
> Thanks Ed, I think I might just remove the /** on that function then
> (removing it from kdoc processing)
I dunno, that means
a) kerneldoc won't generate html for this struct
b) new additions to the struct without corresponding kerneldoc won't
?? generate warnings
?both of which are not ideal outcomes.
I realise there's value in having totally warning-clean code, but in
?this case I think this one warning, even though it's indicating a
?toolchain problem rather than a codebase problem, should better stay
?(if only to put pressure on the toolchain to fix it).
Otherwise, when and if the toolchain is fixed, what's the chance we'll
?remember to put the /** back?

That's just my opinion, though; I won't block patches that disagree.

-ed
