From: Andre Guedes <andre.guedes@intel.com>
Date: Thu, 12 Nov 2020 13:58:21 -0800
Subject: [Intel-wired-lan] [PATCH v4 7/9] igc: Add initial XDP support
In-Reply-To: <5cec65f6-a155-57d8-623e-4308ac62ba0f@intel.com>
References: <20201104031210.27772-1-andre.guedes@intel.com>
 <20201104031210.27772-8-andre.guedes@intel.com>
 <5cec65f6-a155-57d8-623e-4308ac62ba0f@intel.com>
Message-ID: <160521830157.29792.4388568942163519947@ngilbert-mobl1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Neftin, Sasha (2020-11-12 01:13:27)
> > +#define IGC_XDP_PASS         0
> > +#define IGC_XDP_CONSUMED     BIT(0)
> > +
> Hello Andre, please, move these defines to igc_defines.h to bottom the 
> file under /* XDP defines */ comment.

Hi Sasha, looking at the macros defined in igc_defines.h, they seem to be
hardware-related (registers, fields, masks, etc) which is not the case of
the XDP macros defined here. In addition to that, note that these macros
are used only in igc_main.c so maybe it makes sense to leave them here?
