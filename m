From: Richard Cochran <richardcochran@gmail.com>
Date: Sat, 12 Oct 2019 16:27:19 -0700
Subject: [Intel-wired-lan] [net-next v3 3/7] mv88e6xxx: reject
 unsupported external timestamp flags
In-Reply-To: <02874ECE860811409154E81DA85FBB5896926B0B@ORSMSX121.amr.corp.intel.com>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
 <20190926181109.4871-4-jacob.e.keller@intel.com>
 <20191012182409.GD3165@localhost>
 <02874ECE860811409154E81DA85FBB5896926B0B@ORSMSX121.amr.corp.intel.com>
Message-ID: <20191012232719.GA7148@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Oct 12, 2019 at 07:36:31PM +0000, Keller, Jacob E wrote:
> Right, so in practice, unless it supports both edges, it should reject setting both RISING and FALLING together.

Enforcing that now *could* break existing user space, but I wonder
whether any programs would actually be affected.

Maybe we can add a STRICT flag than requests strict checking.  If user
space uses the "2" ioctl, then we would add this flag before invoking
the driver callback.

Thanks,
Richard
