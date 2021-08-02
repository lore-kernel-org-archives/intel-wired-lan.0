From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 2 Aug 2021 09:49:07 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <20210802145937.1155571-1-arnd@kernel.org>
References: <20210802145937.1155571-1-arnd@kernel.org>
Message-ID: <20210802164907.GA9832@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 02, 2021 at 04:59:33PM +0200, Arnd Bergmann wrote:

> This is a recurring problem in many drivers, and we have discussed
> it several times befores, without reaching a consensus. I'm providing
> a link to the previous email thread for reference, which discusses
> some related problems, though I can't find what reasons there were
> against the approach with the extra Kconfig dependency.

Quoting myself in the thread from 12 Nov 2020:

   This whole "implies" thing turned out to be a colossal PITA.

   I regret the fact that it got merged.  It wasn't my idea.

This whole thing came about because Nicolas Pitre wanted to make PHC
core support into a module and also to be able to remove dynamic posix
clock support for tinification.  It has proved to be a never ending
source of confusion.

Let's restore the core functionality and remove "implies" for good.

Thanks,
Richard
