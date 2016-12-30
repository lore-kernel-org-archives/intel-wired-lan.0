From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Fri, 30 Dec 2016 09:10:27 -0800
Subject: [Intel-wired-lan] [net-next PATCH 3/6] i40e: Sync link state
	between VFs and VFPRs
In-Reply-To: <CAJ3xEMiQaVc=aJMFJdWEDHEeYL5NnxAcqbM_cTa+X5CkNrLtZg@mail.gmail.com>
References: <1483078863-22026-1-git-send-email-sridhar.samudrala@intel.com>
 <1483078863-22026-4-git-send-email-sridhar.samudrala@intel.com>
 <CAJ3xEMiQaVc=aJMFJdWEDHEeYL5NnxAcqbM_cTa+X5CkNrLtZg@mail.gmail.com>
Message-ID: <58669503.2070502@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/30/2016 7:43 AM, Or Gerlitz wrote:
> On Fri, Dec 30, 2016 at 8:21 AM, Sridhar Samudrala
> <sridhar.samudrala@intel.com> wrote:
>
> [..]
>> - enable/disable VF link state via ndo_set_vf_link_state will update the
>>    admin state of associated VFPR.
> why you want to do that? anything missing here w.o using the legacy mode?
Nothing missing.  legacy way of controlling the VF link state is 
supported even in switchdev mode
until it is deprecated.
