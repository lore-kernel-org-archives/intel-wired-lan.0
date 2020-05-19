From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 19 May 2020 15:39:54 -0700
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <20200516012948.3173993-1-vinicius.gomes@intel.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
Message-ID: <158992799425.36166.17850279656312622646@twxiong-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Quoting Vinicius Costa Gomes (2020-05-15 18:29:44)
> One example, for retrieving and setting the configuration:
> 
> $ ethtool $ sudo ./ethtool --show-frame-preemption enp3s0
> Frame preemption settings for enp3s0:
>         support: supported
>         active: active

IIUC the code in patch 2, 'active' is the actual configuration knob that
enables or disables the FP functionality on the NIC.

That sounded a bit confusing to me since the spec uses the term 'active' to
indicate FP is currently enabled at both ends, and it is a read-only
information (see 12.30.1.4 from IEEE 802.1Q-2018). Maybe if we called this
'enabled' it would be more clear.

>         supported queues: 0xf
>         supported queues: 0xe
>         minimum fragment size: 68

I'm assuming this is the configuration knob for the minimal non-final fragment
defined in 802.3br.

My understanding from the specs is that this value must be a multiple from 64
and cannot assume arbitrary values like shown here. See 99.4.7.3 from IEEE
802.3 and Note 1 in S.2 from IEEE 802.1Q. In the previous discussion about FP,
we had this as a multiplier factor, not absolute value.

Regards,

Andre
