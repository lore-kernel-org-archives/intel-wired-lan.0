From: Felicitas Hetzelt <felicitashetzelt@gmail.com>
Date: Mon, 6 Sep 2021 14:04:55 +0200
Subject: [Intel-wired-lan] Potential oob access in e100.c:get_regs(_len)
In-Reply-To: <c2ca99a7-9389-de32-bf2d-5128158a094a@intel.com>
References: <1f52bd29-43e7-0639-57cf-abfb7dc9804b@sect.tu-berlin.de>
 <c2ca99a7-9389-de32-bf2d-5128158a094a@intel.com>
Message-ID: <d656c5d2-bdb6-5b05-1c4a-bcf6ec9194df@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,
> Are you seeing the same thing I am?

Seems to me like you are right! I wonder why this was never caught though.

Also, KASAN did trigger on this path which I guess is an indication that
there in fact is a problem.


Regards,

Felicitas

