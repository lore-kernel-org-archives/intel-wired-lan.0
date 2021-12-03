From: Ido Schimmel <idosch@idosch.org>
Date: Fri, 3 Dec 2021 17:58:20 +0200
Subject: [Intel-wired-lan] [PATCH v4 net-next 2/4] ethtool: Add ability
 to configure recovered clock for SyncE feature
In-Reply-To: <MW5PR11MB581202E2A601D34E30F1E5AEEA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
References: <20211201180208.640179-1-maciej.machnikowski@intel.com>
 <20211201180208.640179-3-maciej.machnikowski@intel.com>
 <Yai/e5jz3NZAg0pm@shredder>
 <MW5PR11MB5812455176BC656BABCFF1B0EA699@MW5PR11MB5812.namprd11.prod.outlook.com>
 <Yaj13pwDKrG78W5Y@shredder>
 <PH0PR11MB583105F8678665253A362797EA699@PH0PR11MB5831.namprd11.prod.outlook.com>
 <87pmqdojby.fsf@nvidia.com>
 <MW5PR11MB581202E2A601D34E30F1E5AEEA6A9@MW5PR11MB5812.namprd11.prod.outlook.com>
Message-ID: <Yao+nK40D0+u8UKL@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Dec 03, 2021 at 02:55:05PM +0000, Machnikowski, Maciej wrote:
> If you have 32 port switch chip with 2 recovered clock outputs how will you
> tell the chip to get the 18th port to pin 0 and from port 20 to pin 1? That's
> the part those patches addresses. The further side of "which clock should the
> EEC use" belongs to the DPLL subsystem and I agree with that.
> 
> Or to put it into different words:
> This API will configure given quality level  frequency reference outputs on chip's
> Dedicated outputs. On a board you will connect those to the EEC's reference inputs.

So these outputs are hardwired into the EEC's inputs and are therefore
only meaningful as EEC inputs? If so, why these outputs are not
configured via the EEC object?

> 
> The EEC's job is to validate the inputs and lock to them following certain rules,
> The PHY/MAC (and this API) job is to deliver reference signals to the EEC. 
> 
