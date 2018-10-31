From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 30 Oct 2018 19:25:55 -0700
Subject: [Intel-wired-lan] [RFC PATCH 0/4] More accurate PHC<->system
 clock synchronization
In-Reply-To: <20181026162742.631-1-mlichvar@redhat.com>
References: <20181026162742.631-1-mlichvar@redhat.com>
Message-ID: <20181031022555.ghpm7654n5jp43uq@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 26, 2018 at 06:27:38PM +0200, Miroslav Lichvar wrote:
> The other patches add support for the new ioctl to the e1000e, igb,
> and ixgbe driver. Tests with few different NICs in different machines
> (and PCIe slots) show that:
> - with an I219 (e1000e) the measured delay improved from 2500 to 1300 ns
>   and the error in the measured offset, when compared to cross
>   timestamping, was reduced by a factor of 5
> - with an I210 (igb) the delay improved from 5100 to 1700 ns
> - with an I350 (igb) the delay improved from 2300 to 750 ns
> - with an X550 (ixgbe) the delay improved from 1950 to 650 ns

Nice work!  This is a welcome improvement.

Thanks,
Richard
