From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 21 Jan 2020 13:59:04 -0800
Subject: [Intel-wired-lan] [PATCH v1] igc: Complete to commit Add basic
 skeleton for PTP
In-Reply-To: <20200120063350.36467-1-sasha.neftin@intel.com>
References: <20200120063350.36467-1-sasha.neftin@intel.com>
Message-ID: <87o8uw31zr.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sasha,

Sasha Neftin <sasha.neftin@intel.com> writes:

> commit 5f2958052c58 ("igc: Add basic skeleton for PTP")
> Add ptp suspend method to the igc_shutdown.

I guess the commit message could use a bit more text, something like
this:

"Commit 5f2958052c58 ("igc: Add basic skeleton for PTP") added basic
support for PTP, what's missing is support for suspending. By cleaning
the runtime storage for timestamp this avoids a possible invalid memory
access when the system comes back from suspend."

Apart from that, the code looks good.

Is this the only thing missing for suspend/resume to work? If so, that's
cool :-)


Cheers,
--
Vinicius
