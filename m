From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 12 Nov 2019 17:58:09 -0800
Subject: [Intel-wired-lan] [net-next v3 0/7] new PTP ioctl fixes
In-Reply-To: <20190926181109.4871-1-jacob.e.keller@intel.com>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
Message-ID: <20191113015809.GA8608@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jacob,

On Thu, Sep 26, 2019 at 11:11:02AM -0700, Jacob Keller wrote:
> Jacob Keller (7):
>   ptp: correctly disable flags on old ioctls

This patch made it into net, but ...

>   net: reject PTP periodic output requests with unsupported flags
>   mv88e6xxx: reject unsupported external timestamp flags
>   dp83640: reject unsupported external timestamp flags
>   igb: reject unsupported external timestamp flags
>   mlx5: reject unsupported external timestamp flags
>   renesas: reject unsupported external timestamp flags

.. these did not.

There is still time before v5.4 gets released.  Would you care to
re-submit the missing six patches?

Thanks,
Richard
