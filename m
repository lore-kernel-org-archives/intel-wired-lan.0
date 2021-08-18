From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 18 Aug 2021 10:08:46 -0700
Subject: [Intel-wired-lan] [RFC net-next 0/7] Add basic SyncE interfaces
In-Reply-To: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
Message-ID: <20210818170846.GF9992@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 16, 2021 at 06:07:10PM +0200, Arkadiusz Kubalewski wrote:

> Multiple reference clock sources can be available. PHY ports recover
> the frequency at which the transmitter sent the data on the RX side.
> Alternatively, we can use external sources like 1PPS GPS, etc.

There is a generic PHY subsystem (drivers/phy) used by USB, PCIe, CAN,
and so on.  Why not use that?

Thanks,
Richard
