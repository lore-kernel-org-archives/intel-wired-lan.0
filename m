From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 2 Aug 2021 16:09:21 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
Message-ID: <20210802230921.GA13623@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 02, 2021 at 07:54:20PM +0000, Keller, Jacob E wrote:
> So go back to "select"?

Why not keep it simple?

PTP core:
   Boolean PTP_1588_CLOCK

drivers:
   depends on PTP_1588_CLOCK

Also, make Posix timers always part of the core.  Tinification is a
lost cause.

Thanks,
Richard

