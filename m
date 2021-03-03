From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed, 3 Mar 2021 02:51:12 +0200
Subject: [Intel-wired-lan] [PATCH net-next v3 1/8] ethtool: Add support
 for configuring frame preemption
In-Reply-To: <87o8g1nk6g.fsf@vcostago-mobl2.amr.corp.intel.com>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
 <20210122224453.4161729-2-vinicius.gomes@intel.com>
 <20210302142350.4tu3n4gay53cjnig@skbuf>
 <87o8g1nk6g.fsf@vcostago-mobl2.amr.corp.intel.com>
Message-ID: <20210303005112.im2zur47553uv2ld@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 02, 2021 at 04:40:55PM -0800, Vinicius Costa Gomes wrote:
> Hi Vladimir,
>
> Vladimir Oltean <olteanv@gmail.com> writes:
>
> > Hi Vinicius,
> >
> > On Fri, Jan 22, 2021 at 02:44:46PM -0800, Vinicius Costa Gomes wrote:
> >> Frame preemption (described in IEEE 802.3br-2016) defines the concept
> >> of preemptible and express queues. It allows traffic from express
> >> queues to "interrupt" traffic from preemptible queues, which are
> >> "resumed" after the express traffic has finished transmitting.
> >>
> >> Frame preemption can only be used when both the local device and the
> >> link partner support it.
> >>
> >> Only parameters for enabling/disabling frame preemption and
> >> configuring the minimum fragment size are included here. Expressing
> >> which queues are marked as preemptible is left to mqprio/taprio, as
> >> having that information there should be easier on the user.
> >>
> >> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> >> ---
> >
> > I just noticed that the aMACMergeStatusVerify variable is not exposed in
> > the PREEMPT_GET command, which would allow the user to inspect the state
> > of the MAC merge sublayer verification state machine. Also, a way in the
> > PREEMPT_SET command to set the disableVerify variable would be nice.
> >
>
> The hardware I have won't have support for this.

What exactly is not supported, FP verification or the disabling of it?
Does your hardware at least respond to verification frames?

> I am going to send the next version of this series soon. Care to send
> the support for verifyStatus/disableVerify as follow up series?
