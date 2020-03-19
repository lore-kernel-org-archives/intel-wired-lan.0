From: Andre Guedes <andre.guedes@linux.intel.com>
Date: Thu, 19 Mar 2020 14:59:12 -0700
Subject: [Intel-wired-lan] [PATCH v2] igc: add support to interrupt,
 eeprom, registers and link self-tests
In-Reply-To: <20200318135446.10921-1-vitaly.lifshits@intel.com>
References: <20200318135446.10921-1-vitaly.lifshits@intel.com>
Message-ID: <158465515217.38369.8668630576224913708@aarayaol-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vitaly,

Quoting Vitaly Lifshits (2020-03-18 06:54:46)
> +u64 igc_link_test(struct igc_adapter *adapter, u64 *data)
> +{
> +       bool link_up = false;

No need to initialize this variable since it is not read anywhere before
assignment in the end of this function.

> +
> +       if (IGC_REMOVED(adapter->hw.hw_addr)) {
> +               *data = 1;
> +               return 1;
> +       }
> +       *data = 0;
> +
> +       /* add delay to give enough time for autonegotioation to finish */
> +       if (adapter->hw.mac.autoneg)
> +               ssleep(5);
> +
> +       link_up = igc_has_link(adapter);
> +       if (!link_up)
> +               *data = 1;
> +
> +       return *data;
> +}

Regards,

Andre
