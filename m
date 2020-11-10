From: Miroslav Lichvar <mlichvar@redhat.com>
Date: Tue, 10 Nov 2020 19:07:19 +0100
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20201110061019.519589-4-vinicius.gomes@intel.com>
References: <20201110061019.519589-1-vinicius.gomes@intel.com>
 <20201110061019.519589-4-vinicius.gomes@intel.com>
Message-ID: <20201110180719.GA1559650@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 09, 2020 at 10:10:19PM -0800, Vinicius Costa Gomes wrote:
> i225 has support for PCIe PTM, which allows us to implement support
> for the PTP_SYS_OFFSET_PRECISE ioctl(), implemented in the driver via
> the getcrosststamp() function.

Would it be possible to provide the PTM measurements with the
PTP_SYS_OFFSET_EXTENDED ioctl instead of PTP_SYS_OFFSET_PRECISE?

As I understand it, PTM is not cross timestamping. It's basically
NTP over PCIe, which provides four timestamps with each "dialog". From
the other constants added to the header file it looks like they could
all be obtained and then they could be converted to the triplets
returned by the EXTENDED ioctl.

The main advantage would be that it would provide applications with
the round trip time, which is important to estimate the maximum error
in the measurement. As your example phc2sys output shows, with the
PRECISE ioctl the delay is 0, which is misleading here.

I suspect the estimate would be valid only when the NIC is connected
directly to the PTM root (PCI root complex). Is it possible to get the
timestamps or delay from PTM-capable switches on the path between CPU
and NIC? Also, how frequent can be the PTM dialogs? Could they be
performed synchronously in the ioctl?

-- 
Miroslav Lichvar

