From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Fri, 30 Dec 2016 17:43:10 +0200
Subject: [Intel-wired-lan] [net-next PATCH 3/6] i40e: Sync link state
	between VFs and VFPRs
In-Reply-To: <1483078863-22026-4-git-send-email-sridhar.samudrala@intel.com>
References: <1483078863-22026-1-git-send-email-sridhar.samudrala@intel.com>
 <1483078863-22026-4-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <CAJ3xEMiQaVc=aJMFJdWEDHEeYL5NnxAcqbM_cTa+X5CkNrLtZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Dec 30, 2016 at 8:21 AM, Sridhar Samudrala
<sridhar.samudrala@intel.com> wrote:

[..]
> - enable/disable VF link state via ndo_set_vf_link_state will update the
>   admin state of associated VFPR.

why you want to do that? anything missing here w.o using the legacy mode?
