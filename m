From: Joergen Andreasen <joergen.andreasen@microchip.com>
Date: Wed, 20 May 2020 14:52:32 +0200
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <87y2pnmr83.fsf@intel.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <158992799425.36166.17850279656312622646@twxiong-mobl.amr.corp.intel.com>
 <87y2pnmr83.fsf@intel.com>
Message-ID: <20200520125232.s3zrmlnesqjilcf6@soft-dev16>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The 05/19/2020 16:37, Vinicius Costa Gomes wrote:
> 
> Andre Guedes <andre.guedes@intel.com> writes:
> 
> > Hi,
> >
> > Quoting Vinicius Costa Gomes (2020-05-15 18:29:44)
> >> One example, for retrieving and setting the configuration:
> >>
> >> $ ethtool $ sudo ./ethtool --show-frame-preemption enp3s0
> >> Frame preemption settings for enp3s0:
> >>         support: supported
> >>         active: active
> >
> > IIUC the code in patch 2, 'active' is the actual configuration knob that
> > enables or disables the FP functionality on the NIC.
> >
> > That sounded a bit confusing to me since the spec uses the term 'active' to
> > indicate FP is currently enabled at both ends, and it is a read-only
> > information (see 12.30.1.4 from IEEE 802.1Q-2018). Maybe if we called this
> > 'enabled' it would be more clear.
> 
> Good point. Will rename this to "enabled".
> 
> >
> >>         supported queues: 0xf
> >>         supported queues: 0xe
> >>         minimum fragment size: 68
> >
> > I'm assuming this is the configuration knob for the minimal non-final fragment
> > defined in 802.3br.
> >
> > My understanding from the specs is that this value must be a multiple from 64
> > and cannot assume arbitrary values like shown here. See 99.4.7.3 from IEEE
> > 802.3 and Note 1 in S.2 from IEEE 802.1Q. In the previous discussion about FP,
> > we had this as a multiplier factor, not absolute value.
> 
> I thought that exposing this as "(1 + N)*64" (with 0 <= N <= 3) that it
> was more related to what's exposed via LLDP than the actual capabilities
> of the hardware. And for the hardware I have actually the values
> supported are: (1 + N)*64 + 4 (for N = 0, 1, 2, 3).
> 
> So I thought I was better to let the driver decide what values are
> acceptable.
> 
> This is a good question for people working with other hardware.
> 

I think it's most intuitive to use the values for AddFragSize as described in
802.3br (N = 0, 1, 2, 3).
You will anyway have to use one of these values when you want to expose the
requirements of your receiver through LLDP.

> 
> --
> Vinicius

-- 
Joergen Andreasen, Microchip
