From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 12 Oct 2018 20:32:03 +0000
Subject: [Intel-wired-lan] fm10k driver - flow control question
In-Reply-To: <CALQkTo0grSAyR+ObLL3tSG9ev6b-XFVgHHZfjODRNU0MG7xO2g@mail.gmail.com>
References: <CALQkTo1P_QAyW+y_LE=LFK=y+oDfScqZJLxjdn7eifofNbycAQ@mail.gmail.com>
 <CAKgT0UetdOGsVPLu3Ji23FXq_dVVxWPSGsZjDLW9JX3q=CBSEQ@mail.gmail.com>
 <CALQkTo2eqJs0pJcjkGh3bs0yhJ5iz2SJ_e8G+9zYYm2H-k6HQw@mail.gmail.com>
 <CAKgT0Uf-oafDZR7yba1frBQ-iheD+qHg1Hb2G5rBvv4=fEgtzw@mail.gmail.com>
 <9BBC4E0CF881AA4299206E2E1412B6267C64AC16@ORSMSX102.amr.corp.intel.com>
 <CALQkTo03Eh85vmx2-Rt_1g8r9FpecQPh7bbE2-PjQnOu_yS+oQ@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB5884CD29DD@ORSMSX115.amr.corp.intel.com>
 <02874ECE860811409154E81DA85FBB5884CD2A9E@ORSMSX115.amr.corp.intel.com>
 <CALQkTo0grSAyR+ObLL3tSG9ev6b-XFVgHHZfjODRNU0MG7xO2g@mail.gmail.com>
Message-ID: <02874ECE860811409154E81DA85FBB5884CD594C@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Jags N [mailto:jagsnn at gmail.com]
> Sent: Friday, October 12, 2018 12:19 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Wyborny, Carolyn <carolyn.wyborny@intel.com>; intel-wired-lan at osuosl.org
> Subject: Re: [Intel-wired-lan] fm10k driver - flow control question
> 
> Hi Jake,
> 
> Thanks much for clarifying.
> 
> "Basically, there is no method to flow control or equivalent between the PEP (host
> interface) and the switch".
> 
> If the above is the case, can an Application on the Host, if able to send Priority Flow
> Control Pause frames towards the switch, be able to pause the Switch from
> transmitting frames towards Host ?
> 
> Regards,
> Jagdish
> 
> 

As far as I understand it, the switch does not honor flow control frames coming from the host interface. The host interface supports receiving class based PAUSE frames from the switch, but as far as I am able to determine, the switch does not handle port based or class based flow control frames from the host interface.

So, the answer to this question is "no, that's not supported"

Thanks,
Jake

