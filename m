From: Richard Cochran <richardcochran@gmail.com>
Date: Wed, 31 Oct 2018 07:40:03 -0700
Subject: [Intel-wired-lan] [RFC PATCH 4/4] ixgbe: add support for
 extended PHC gettime
In-Reply-To: <20181029133109.GD31668@localhost>
References: <20181026162742.631-1-mlichvar@redhat.com>
 <20181026162742.631-5-mlichvar@redhat.com>
 <02874ECE860811409154E81DA85FBB5884CE4B8C@ORSMSX115.amr.corp.intel.com>
 <20181029133109.GD31668@localhost>
Message-ID: <20181031144003.qs235wjmiuwaprps@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 29, 2018 at 02:31:09PM +0100, Miroslav Lichvar wrote:
> I think there could be a flag in ptp_system_timestamp, or a parameter
> of gettimex64(), which would enable/disable reading of the system
> clock.

I'm not a fan of functions that change their behavior based on flags
in their input parameters.

Thanks,
Richard
